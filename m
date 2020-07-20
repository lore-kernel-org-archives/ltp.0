From: Xiao Yang <ice_yangxiao@163.com>
Date: Mon, 20 Jul 2020 20:30:19 +0800
Subject: [LTP] [PATCH v2 6/7] net/test: Add basic testing for
 tst_rhost_run
In-Reply-To: <20200720115345.GA21201@dell5510>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-7-pvorel@suse.cz> <5F155DB2.8080709@cn.fujitsu.com>
 <20200720115345.GA21201@dell5510>
Message-ID: <9a30538f-bb7b-3fb9-7102-2f75b2d7de8c@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 7/20/20 7:53 PM, Petr Vorel wrote:
> Hi,
>
>>> +	tst_rhost_run -c 'which grep > /dev/null' || \
>>> +		tst_res TCONF "grep not found on rhost"
>> Hi Petr,
>> 1) Do you want to discard stderr as well? For example:
>> -------------------------------------------------
>> # which gre >/dev/null
>> /usr/bin/which: no gre in
>> (/opt/ltp/testcases/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/root/bin)
> That's not needed because tst_rhost_run already redirect stderr to stdout.

Hi Petr,

I think you means tst_rhost_run -c 'which grep' >/dev/null rather than 
tst_rhost_run -c 'which grep > /dev/null'

The current code just discard stdout, for example:

-------------------------------------------------------

[root@Fedora-30-workstation net]# ./tst_rhost_run.sh
...
tst_rhost_run 1 TINFO: NETNS: ns_exec 3079 net,mnt sh -c " which gre > 
/dev/null || echo RTERR" 2>&1
which: no gre in 
(./../../../../testcases/lib/:/usr/share/Modules/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/root/bin:/opt/ltp/testcases/bin)

-------------------------------------------------------

Thanks,

Xiao Yang

>
>> -------------------------------------------------
>> 2) Is it necessary to continue if grep command is not found on rhost?
>> How about calling tst_brk?
> Good catch, I should use tst_brk on both places.
>
>>> +
>>> +	tst_rhost_run -c "[ -f $file ]" || \
>>> +		tst_res TCONF "$file not found on rhost"
>> Call tst_brk as well?
>> Thanks,
>> Xiao Yang
> Thanks!
> Petr
>

