From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 09 Jan 2017 15:11:29 +0300
Subject: [LTP] State of RPC and TI-RPC Test Suite tests
In-Reply-To: <20161230152518.x36fwnj2w2fmkwde@dell5510>
References: <20161230152518.x36fwnj2w2fmkwde@dell5510>
Message-ID: <58737DF1.90306@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 30.12.2016 18:25, Petr Vorel wrote:
> Hi Alexey,
>
> please what is a state of RPC and TI-RPC Test Suite tests (files runtest/rpc_tests and
> runtest/tirpc_tests)? Shouldn't be the files prefixed with net. as the other networking
> tests? I suppose they're not deprecated / obsolete.

Sure, these tests can be perfixed with "net". At least, we could modify

"testcases/network/rpc/rpc-tirpc/rpc_test.sh"

script to source test_net.sh. Right now you can run the tests on 
locahost or via RSH (in case of two hosts).

Thanks,
Alexey

