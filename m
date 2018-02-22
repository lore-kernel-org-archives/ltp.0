From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Thu, 22 Feb 2018 15:57:15 +0800
Subject: [LTP] report a error about vlan01.sh
In-Reply-To: <7a932f3d-910e-bb59-3a3b-cb49748d5b62@oracle.com>
References: <a91d75c3-a154-dc04-bf46-ac9bd234006f@cn.fujitsu.com>
 <7a932f3d-910e-bb59-3a3b-cb49748d5b62@oracle.com>
Message-ID: <c28dbdfa-89e2-a43f-25bc-4d4c7150c3d0@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 02/12/2018 08:09 PM, Alexey Kodanev wrote:
> On 02/12/2018 03:16 AM, sunlianwen wrote:
>> Hi Alexey
>>
>>      I find a error about ltp vlan01 test case, but I not sure whether I think is right. and the author of this case is your, if possible I hope you
>>
>>    revise this case.
>>
>>    error info "RTNETLINK answers: Numerical result out of range" will see when exec vlan01 testcase , and I debug this case. I find
>>
>>    this error info cause by vlanID, because the range of vlanID is  "0-4095", so when exec "ip link add link eth1 name ltp_v4095
>>
>>    type vlan id 4095 protocol 802.1Q loose_binding off reorder_hdr on"  the error will happen.
>>
>>    whether  can revise the virt_multiple_add_test() function, let the vlanid range is fixed  "1-2000".
>>
> Hi,
>
> You are right, you could try to lower NS_TIMES environment variable,
> it is too high for the number of the test-cases vlan01 has. The total
> number of different vlan ids created when NS_TIMES equals 2000 will be
> 2000 * 9, when none of the test-cases are skipped.
>
> Since each test-case removes the created devices after completion we
> could remove the addition of 'NS_TIMES' to the 'start_id' on the each
> iteration in virt_test_01():
>
> diff --git a/testcases/network/virt/virt_lib.sh b/testcases/network/virt/virt_lib.sh
> index a3532ec..30211fa 100644
> --- a/testcases/network/virt/virt_lib.sh
> +++ b/testcases/network/virt/virt_lib.sh
> @@ -372,8 +372,6 @@ virt_test_01()
>                  virt_check_cmd virt_add ltp_v0 id 0 $p || continue
>
>                  virt_multiple_add_test "$p"
> -
> -               start_id=$(($start_id + $NS_TIMES))
>          done
>   }
>
>
> Plus, we should limit NS_TIMES in vlan tests anyway...
Hi Alexey

   Thanks for your answer. But I am sorry, I still have to trouble you 
to merge this patch to the master branch as soon as possible.

so that I can use new vlan01.sh to test new linux release.

Thanks,
Lianwen Sun
>
> Thanks,
> Alexey
>
>> the path of error file: ltp/testcases/network/virt/virt_lib.sh
>>
>> 144 virt_multiple_add_test()
>> 145 {
>> 146         local opt="$@"
>> 147         local max=$(($start_id + $NS_TIMES - 1))
>> 148
>> 149         tst_resm TINFO "add $NS_TIMES $virt_type, then delete"
>> 150
>> 151         for i in $(seq $start_id $max); do
>> 152                 virt_add ltp_v$i id $i $opt || \
>> 153                         tst_brkm TFAIL "failed to create 'ltp_v0 $opt'"
>> 154                 ROD_SILENT "ip link set ltp_v$i up"
>> 155         done
>> 156
>> 157         for i in $(seq $start_id $max); do
>> 158                 ROD_SILENT "ip link set ltp_v$i down"
>> 159                 ROD_SILENT "ip link delete ltp_v$i"
>> 160         done
>> 161
>> 162         tst_resm TPASS "done"
>> 163 }
>>
>> file path: iproute-4.11.0-0.el7/ip/iplink_vlan.c
>>
>> 21 static void print_explain(FILE *f)
>>   22 {
>>   23         fprintf(f,
>>   24                 "Usage: ... vlan id VLANID\n"
>>   25                 "                [ protocol VLANPROTO ]\n"
>>   26                 "                [ reorder_hdr { on | off } ]\n"
>>   27                 "                [ gvrp { on | off } ]\n"
>>   28                 "                [ mvrp { on | off } ]\n"
>>   29                 "                [ loose_binding { on | off } ]\n"
>>   30                 "                [ ingress-qos-map QOS-MAP ]\n"
>>   31                 "                [ egress-qos-map QOS-MAP ]\n"
>>   32                 "\n"
>>   33              "VLANID := 0-4095\n"
>>   34                 "VLANPROTO: [ 802.1Q / 802.1ad ]\n"
>>   35                 "QOS-MAP := [ QOS-MAP ] QOS-MAPPING\n"
>>   36                 "QOS-MAPPING := FROM:TO\n"
>>   37         );
>>   38 }
>>
>> line 33 ,we can know, the range of VlANID is 0-4095
>>
>>
>> the  vlan01 test result is below
>>
>> <<<test_output>>>
>> incrementing stop
>> vlan01 1 TINFO: Network config (local -- remote):
>> vlan01 1 TINFO: eth1 -- eth1
>> vlan01 1 TINFO: 192.168.122.44/24 -- 192.168.122.46/24
>> vlan01 1 TINFO: fec0:0:0:1::1/64 -- fec0:0:0:1::2/64
>> vlan01 1 TINFO: add vlan with ''
>> vlan01 1 TINFO: add 2000 vlan, then delete
>> vlan01 1 TPASS: done
>> vlan01 2 TINFO: add vlan with 'protocol 802.1Q loose_binding off reorder_hdr off'
>> vlan01 2 TINFO: add 2000 vlan, then delete
>> vlan01 2 TPASS: done
>> vlan01 3 TINFO: add vlan with 'protocol 802.1Q loose_binding off reorder_hdr on'
>> vlan01 3 TINFO: add 2000 vlan, then delete
>> *RTNETLINK answers: Numerical result out of range**
>> **vlan01 3 TFAIL: failed to create 'ltp_v0 protocol 802.1Q loose_binding off reorder_hdr on'*
>> vlan01 4 TINFO: cleanup virtual interfaces...
>> <<<execution_status>>>
>> initiation_status="ok"
>> duration=85 termination_type=exited termination_id=1 corefile=no
>> cutime=1322 cstime=2449
>> <<<test_end>>>
>> INFO: ltp-pan reported some tests FAIL
>> LTP Version: 20180118
>>
>>         ###############################################################
>>
>>              Done executing testcases.
>>              LTP Version:  20180118
>>         ###############################################################
>>
>> That is all  ,thanks very much.
>>
>
>
> .
>



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180222/2aee7c4a/attachment.html>
