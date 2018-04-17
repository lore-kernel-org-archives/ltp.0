From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 17 Apr 2018 14:34:12 +0300
Subject: [LTP] [PATCH 1/1] network/vxlan02.sh: Fix duplicate parameters
In-Reply-To: <1ea39ca6-a8c1-92b1-809f-8df162d36ee0@oracle.com>
References: <20180416221141.2781-1-pvorel@suse.cz>
 <1ea39ca6-a8c1-92b1-809f-8df162d36ee0@oracle.com>
Message-ID: <68b8a150-1dc5-258b-ca43-98599954c400@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 04/17/2018 12:48 PM, Alexey Kodanev wrote:
> On 04/17/2018 01:11 AM, Petr Vorel wrote:
>> vxlan02 and vxlan02_ipv6 tests had duplicate parameters 'dev ltp_ns_veth2':
>> ip li add ltp_v0 type vxlan dstport 0 id 16700000 group 239.1.1.1 dev ltp_ns_veth2 dev ltp_ns_veth2
>> Error: either "dev" is duplicate, or "ltp_ns_veth2" is a garbage.
>>
>> Device was specified in in both the test file itself and in virt_add() function in virt_lib.sh.
>> Removed in test to be consistent with vlan02.sh.
>>

Hi Petr,

Not related to the patch, also noted that now vxlan03.sh tests
have some errors when parsing the args. Not sure if it has any
effect on the test itself...

vxlan03.sh -d uni
/opt/ltp/testcases/bin/vxlan03.sh: illegal option -- d
/opt/ltp/testcases/bin/tst_net.sh: line 37: ?: command not found


Thanks,
Alexey
