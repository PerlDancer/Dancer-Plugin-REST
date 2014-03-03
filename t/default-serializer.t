use strict;
use warnings;

{
    use Dancer ':tests';
    use Dancer::Plugin::REST;

    prepare_serializer_for_format;
    set serializer => 'XML';

    get '/foo' => sub {
        return { hello => 'world' };
    };

    get '/foo.:format' => sub {
        return { hello => 'world' };
    };

}

use Test::More tests => 3;
use Dancer::Test;

response_content_like '/foo' => qr/<data/, "default serializer is XML";

response_content_like '/foo.json' => qr/"hello"\s*:\s*"world"/, "ask for JSON";

response_content_like '/foo' => qr/<data/, "default serializer is still XML";
