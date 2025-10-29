CREATE TRIGGER trigger_property_update_timestamp
AFTER UPDATE ON property
FOR EACH ROW
EXECUTE FUNCTION update_property_timestamp();
