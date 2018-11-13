From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 13 Nov 2018 18:11:44 +0300
Subject: [LTP] [PATCH 0/6] network: new tests for mpls over gre,
 gre6 and sit
In-Reply-To: <20181102201553.GA14718@dell5510>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
 <20181102201553.GA14718@dell5510>
Message-ID: <b10bea1c-bfe9-3b52-a5cb-a30bf6b85d50@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/02/2018 11:15 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>> Before using sit tunnels with MPLS, add stand-alone sit01 test.
>> It is done by the first two patches.
> 
>> The rest of the patches add various MPLS tests:
>>  * mpls01: functional test, creates/removes MPLS routes,
>>    checks sysctl parameters.
>>  * mpls02: MPLS over the default test network configuration
>>  * mpls03/mpls04: MPLS over GRE and SIT.
> 
>> Alexey Kodanev (6):
>>   network/virt: add support for sit tunnel
>>   network/sit01: new test for sit tunnel
>>   network/mpls01: new test for mpls labels
>>   network/mpls02: new test with lwtunnel
>>   network/mpls03: add MPLS over GRE and GREv6
>>   network/mpls04: new test with mpls over sit tunnel
> 
> Thanks for patches, LGTM.
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
> I've sent some minor issues to 4/6 and 5/6.
> 

All fixed, thanks for review Petr! Applied.
