CREATE OR REPLACE FUNCTION time_from_uuidv1
    AS (guid) -> IF(substring(toString(guid), 15, 1) = '1'
                  , toDateTime(
                        toInt32(
                            (reinterpretAsInt64(
                                reverse(
                                    unhex(
                                        substring(toString(guid)
                                                , 16
                                                , 3) ||
                                        substring(toString(guid)
                                                , 10
                                                , 4) ||
                                        substring(toString(guid)
                                                , 1
                                                , 8)
                                        )
                                    )
                                ) -
                        122192928000000000) /
                        10000000)
                    )
                  , null);
