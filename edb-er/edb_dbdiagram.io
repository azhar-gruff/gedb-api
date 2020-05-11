Table ProductSupplyMaster as PSM {
  product_code varchar
  product_offering_name varchar
  offer_start_date date
  offer_end_date date
  commodity_status varchar
}

Table ProductMaster as PM {
  product_code varchar [pk, ref: - PSM.product_code]
  product_name varchar
  base_or_option varchar
  claims_running_in_days integer
  allowable_number_of_people integer
  category varchar
  minimum_purchase_number integer
  minimum_purchase_quantity_unit integer
}

Ref: PM.product_code < PUL.product_code

Table ProductCombinationMaster as PCM {
  commodity_combination_code varchar [pk]
  product_combination_name varchar
  combination_inhibition_flag varchar
}

Table ProductCombinationSupplyMaster as PCSM {
  commodity_combination_code varchar
  product_code varchar
  individual_cancelation_p_flag varchar
  required_at_first_time_application varchar
  availability_start_date date
  availabiity_end_date date

}


Table ParentProductLink as PPL {
  parent_product_code varchar
  child_product_code  varchar
  commodity_combination_code varchar
  start_date date
  end_date date
}

Table ProductUnitLink as PUL {
  product_unit_code varchar pk
  product_code varchar
  unit_number int
  minimum_unit_purchase_number int
  minimum_unit_purchase_unit int  
}



Ref: PCM."commodity_combination_code" < PCSM."commodity_combination_code"

Ref: PCM.commodity_combination_code < PPL.commodity_combination_code

Ref: PM.product_code < PCSM.product_code

Ref: PM.product_code < PPL.parent_product_code

Ref: PM.product_code < PPL.child_product_code

Table contract_company_base_connection as CCBC {
  company_base_code varchar
  contract_code varchar
  contact_person varchar
  contact_person_fixed_phonenumber varchar
  contact_person_mobile_phonenumber varchar
  contact_person_email_address  varchar
}

Table contract_status as CS {
  contract_code varchar pk
  status varchar
  date date
  contract_start date
  contract_end date
  remarks varchar
}

Table contract_master as CM {
  sequence_number int [pk, increment]
  contract_code varchar
  product_code varchar
  installation_location varchar
  presence_of_fixed_IP boolean
  available_for_loan boolean
  status varchar
  contract_start_date date
  contract_end_date date
  commodity_contract_start_date date
  commodity_contracts_end date
  commodity_combination_code date
  latest_flag varchar 
  application_form_internal_number numeric
  quantity int
}

Table system_management_master as SMM {
  system_code varchar pk
  system_name varchar
}

Table application_number_management as ANM {
  application_form_internal_number numeric pk
  application_form_external_number numeric
  system_code varchar

}

Table application_management_master as AMM {
  application_form_internal_number numeric pk
  project_name varchar
  contract_date date
  ordering_division varchar
  billing_frequency varchar
  automatic_updating varhcar
}

Table related_contracts as RC {
  grouping_number numeric pk
  main_contract_code varchar
  sub_contract_code varchar
  relation varchar [note: 'parent and child, set']
  start_date date
  end_date date
}


Ref: "contract_master"."contract_code" < "contract_company_base_connection"."contract_code"


Ref: "contract_master"."product_code" < "ProductMaster"."product_name"

Ref: "contract_master"."contract_code" > "contract_status"."contract_code"

Ref: "system_management_master"."system_code" < "application_number_management"."system_code"

Ref: ANM."application_form_internal_number" < AMM."application_form_internal_number"

Ref: CM."application_form_internal_number" > AMM."application_form_internal_number"

Ref: CM."application_form_internal_number" < ANM."application_form_internal_number"

Ref: "contract_master"."commodity_combination_code" < "ProductCombinationMaster"."commodity_combination_code"

Ref: "contract_master"."contract_code" < RC."main_contract_code"

Ref: "contract_master"."contract_code" < RC."sub_contract_code"


Table contract_prohibited_master {
  company_uniform_code varchar
  product_code varhcar
  contract_prohibited_start_date date 
  contract_prohibited_end_date date
  remarks varchar 
}



Ref: "ProductMaster"."product_code" < "contract_prohibited_master"."product_code"


Table corporate_office {
  company_uniform_code varchar 
  company_base_code varchar pk
  site_name varchar
  base_attribute varchar
  business varchar
}

Table street_address {
  address_code varchar pk
  company_base_code varchar
  general_address_code varchar pk
  postal_code varchar
  prefecture varchar
  city varchar
  town_area varchar
  chome varchar
  address_other varchar
  address_application varchar
}

Ref: "corporate_office"."company_base_code" < "contract_company_base_connection"."company_base_code"

Ref: "corporate_office"."company_base_code" < "street_address"."company_base_code"

Ref: "contract_master"."contract_code" < "contract_master"."product_code"