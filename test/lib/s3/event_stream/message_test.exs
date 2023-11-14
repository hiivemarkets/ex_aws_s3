defmodule ExAws.S3.EventStream.MessageTest do
  use ExUnit.Case, async: true

  alias ExAws.S3.Parsers.EventStream

  describe "Message.parse/1" do
    test "parses a binary EventStream Records chunk" do
      chunk =
        <<0, 0, 1, 81, 0, 0, 0, 85, 176, 12, 79, 204, 13, 58, 109, 101, 115, 115, 97, 103, 101,
          45, 116, 121, 112, 101, 7, 0, 5, 101, 118, 101, 110, 116, 13, 58, 99, 111, 110, 116,
          101, 110, 116, 45, 116, 121, 112, 101, 7, 0, 24, 97, 112, 112, 108, 105, 99, 97, 116,
          105, 111, 110, 47, 111, 99, 116, 101, 116, 45, 115, 116, 114, 101, 97, 109, 11, 58, 101,
          118, 101, 110, 116, 45, 116, 121, 112, 101, 7, 0, 7, 82, 101, 99, 111, 114, 100, 115,
          123, 34, 73, 68, 34, 58, 34, 49, 34, 44, 34, 78, 97, 109, 101, 34, 58, 34, 80, 108, 97,
          121, 34, 125, 10, 123, 34, 73, 68, 34, 58, 34, 50, 34, 44, 34, 78, 97, 109, 101, 34, 58,
          34, 68, 101, 116, 97, 105, 108, 34, 125, 10, 123, 34, 73, 68, 34, 58, 34, 51, 34, 44,
          34, 78, 97, 109, 101, 34, 58, 34, 68, 105, 114, 101, 99, 116, 111, 114, 34, 125, 10,
          123, 34, 73, 68, 34, 58, 34, 52, 34, 44, 34, 78, 97, 109, 101, 34, 58, 34, 89, 101, 97,
          114, 34, 125, 10, 123, 34, 73, 68, 34, 58, 34, 53, 34, 44, 34, 78, 97, 109, 101, 34, 58,
          34, 80, 114, 101, 115, 101, 110, 116, 34, 125, 10, 123, 34, 73, 68, 34, 58, 34, 54, 34,
          44, 34, 78, 97, 109, 101, 34, 58, 34, 83, 117, 114, 102, 97, 99, 101, 34, 125, 10, 123,
          34, 73, 68, 34, 58, 34, 55, 34, 44, 34, 78, 97, 109, 101, 34, 58, 34, 65, 34, 125, 10,
          123, 34, 73, 68, 34, 58, 34, 56, 34, 44, 34, 78, 97, 109, 101, 34, 58, 34, 83, 101, 97,
          115, 111, 110, 34, 125, 10, 123, 34, 73, 68, 34, 58, 34, 57, 34, 44, 34, 78, 97, 109,
          101, 34, 58, 34, 70, 105, 114, 101, 34, 125, 10, 66, 109, 206, 248>>

      assert {:ok,
              %EventStream.Message{
                prelude: %EventStream.Prelude{
                  total_length: 337,
                  headers_length: 85,
                  prelude_length: 12,
                  crc: 2_953_596_876,
                  payload_length: 236,
                  prelude_bytes: <<0, 0, 1, 81, 0, 0, 0, 85, 176, 12, 79, 204>>
                },
                headers: %{
                  ":content-type" => "application/octet-stream",
                  ":event-type" => "Records",
                  ":message-type" => "event"
                },
                payload:
                  "{\"ID\":\"1\",\"Name\":\"Play\"}\n{\"ID\":\"2\",\"Name\":\"Detail\"}\n{\"ID\":\"3\",\"Name\":\"Director\"}\n{\"ID\":\"4\",\"Name\":\"Year\"}\n{\"ID\":\"5\",\"Name\":\"Present\"}\n{\"ID\":\"6\",\"Name\":\"Surface\"}\n{\"ID\":\"7\",\"Name\":\"A\"}\n{\"ID\":\"8\",\"Name\":\"Season\"}\n{\"ID\":\"9\",\"Name\":\"Fire\"}\n"
              }} = parse(chunk)
    end

    test "parses a binary EventStream Stats chunk" do
      chunk =
        <<0, 0, 0, 240, 0, 0, 0, 67, 194, 195, 159, 30, 13, 58, 109, 101, 115, 115, 97, 103, 101,
          45, 116, 121, 112, 101, 7, 0, 5, 101, 118, 101, 110, 116, 13, 58, 99, 111, 110, 116,
          101, 110, 116, 45, 116, 121, 112, 101, 7, 0, 8, 116, 101, 120, 116, 47, 120, 109, 108,
          11, 58, 101, 118, 101, 110, 116, 45, 116, 121, 112, 101, 7, 0, 5, 83, 116, 97, 116, 115,
          60, 63, 120, 109, 108, 32, 118, 101, 114, 115, 105, 111, 110, 61, 34, 49, 46, 48, 34,
          32, 101, 110, 99, 111, 100, 105, 110, 103, 61, 34, 85, 84, 70, 45, 56, 34, 63, 62, 60,
          83, 116, 97, 116, 115, 62, 60, 66, 121, 116, 101, 115, 83, 99, 97, 110, 110, 101, 100,
          62, 49, 48, 48, 49, 60, 47, 66, 121, 116, 101, 115, 83, 99, 97, 110, 110, 101, 100, 62,
          60, 66, 121, 116, 101, 115, 80, 114, 111, 99, 101, 115, 115, 101, 100, 62, 49, 48, 48,
          49, 60, 47, 66, 121, 116, 101, 115, 80, 114, 111, 99, 101, 115, 115, 101, 100, 62, 60,
          66, 121, 116, 101, 115, 82, 101, 116, 117, 114, 110, 101, 100, 62, 50, 51, 54, 60, 47,
          66, 121, 116, 101, 115, 82, 101, 116, 117, 114, 110, 101, 100, 62, 60, 47, 83, 116, 97,
          116, 115, 62, 8, 57, 236, 68>>

      assert {:ok,
              %EventStream.Message{
                prelude: %EventStream.Prelude{
                  total_length: 240,
                  headers_length: 67,
                  prelude_length: 12,
                  crc: 3_267_600_158,
                  payload_length: 157,
                  prelude_bytes: <<0, 0, 0, 240, 0, 0, 0, 67, 194, 195, 159, 30>>
                },
                headers: %{
                  ":content-type" => "text/xml",
                  ":event-type" => "Stats",
                  ":message-type" => "event"
                },
                payload:
                  "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Stats><BytesScanned>1001</BytesScanned><BytesProcessed>1001</BytesProcessed><BytesReturned>236</BytesReturned></Stats>"
              }} = parse(chunk)
    end
  end

  defp parse(chunk) do
    {:ok, prelude} = EventStream.Prelude.parse(chunk)
    EventStream.parse_message(prelude, chunk)
  end
end