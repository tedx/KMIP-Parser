#include <kmip.h>

int kmip_db_init(kmip_t *kmip)
{
  kmip->db = (mongo_connection *)malloc(sizeof(mongo_connection));
  if (kmip->db == NULL)
    return -1;

  if (mongo_connect( kmip->db , kmip->db_name, kmip->db_port )) {
    fprintf(stderr, "failed to connect\n");
    return -1;
  }
    /*
    bson b;
    mongo_md5_state_t st;
    mongo_md5_byte_t digest[16];

    bson_init( &b , json_to_bson( js ) , 1 );
    */
  return 0;
}
/*
void kmip_nvp_to_bson_append_element( bson_buffer * bb , kmip_name_value_pair_t *nvp ){
    if ( ! nvp ){
        bson_append_null( bb , nvp->name );
        return;
    }
    
    switch ( nvp->type ){
    case  KMIP_ITEM_TYPE_INTEGER:
    case  KMIP_ITEM_TYPE_ENUMERATION:
        bson_append_int( bb , nvp->name , (int)*((int*)(nvp->value)) );
        break;
    case KMIP_ITEM_TYPE_TEXT_STRING:
      bson_append_string_n( bb , nvp->name, ((char *)(nvp->value)), (int)nvp->len );
	break;
    case KMIP_ITEM_TYPE_BYTE_STRING:
      bson_append_binary( bb , nvp->name, KMIP_ITEM_TYPE_BYTE_STRING, ((const char *)(nvp->value)), (int)nvp->len );
        break;
    default:
        fprintf( stderr , "can't handle type for : %s\n" , nvp->name );
    }
}

bson *kmip_hashmap_to_bson(kmip_name_value_pair_t *nvps)
{
  bson *b;
  bson_buffer *bb;
  kmip_name_value_pair_t *tmp_nvp, *nvp = NULL;

  b = ( bson * )malloc( sizeof( bson ) );
  bb = ( bson_buffer * )malloc( sizeof( bson_buffer ) );

  bson_buffer_init( bb );
  HASH_ITER(hh, nvps, nvp, tmp_nvp) {
    kmip_nvp_to_bson_append_element( bb , nvp );
  }
  bson_buffer_finish( bb );
  bson_from_buffer( b, bb );
  free(bb);

  return b;
}
*/

int kmip_save(kmip_t *kmip, char *collection_name, bson *b)
{
  mongo_insert( kmip->db, collection_name, b );
  return 0;
}
