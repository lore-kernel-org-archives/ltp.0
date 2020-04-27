From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 27 Apr 2020 11:23:34 +0200
Subject: [LTP] [PATCH] Add env variable as workaround for test issues in
 VMs
In-Reply-To: <20200427091933.GA23679@dell5510>
References: <20200424150422.17467-1-mdoucha@suse.cz>
 <20200427053125.GA21164@dell5510>
 <951270734.10286613.1587972682386.JavaMail.zimbra@redhat.com>
 <CAEemH2daE69UT7mFGXOFQaj3bjqq8CRJr6bnhssyK3_7JPdHng@mail.gmail.com>
 <96306598.10298812.1587978418983.JavaMail.zimbra@redhat.com>
 <20200427091933.GA23679@dell5510>
Message-ID: <96b63ea5-7a04-d361-3229-06a7d0998f8c@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 27. 04. 20 11:19, Petr Vorel wrote:
> Hi,
> 
>>> I take a rough look and doubt there is a bug in try_systemd_detect_virt().
>>> Shouldn't strncmp() return zero the 'kvm'/'xen' is found?  I guess they
>>> wanted:
> 
>> Yes, that looks like bug.
> Good catch!
> 
>>> --- a/lib/tst_virt.c
>>> +++ b/lib/tst_virt.c
>>> @@ -93,10 +93,10 @@ static int try_systemd_detect_virt(void)
>>>         if (ret)
>>>                 return 0;
> 
>>> -       if (strncmp("kvm", virt_type, 3))
>>> +       if (!strncmp("kvm", virt_type, 3))
>>>                 return VIRT_KVM;
> 
>>> -       if (strncmp("xen", virt_type, 3))
>>> +       if (!strncmp("xen", virt_type, 3))
>>>                 return VIRT_XEN;
> 
>>>         return 0;
> 
>>> Apart from that two(kvm/xen) , we need to detect more virtualization tech
>>> for ppc/s390 I think.
> 
>> We could return VIRT_OTHER by default. We don't really need to
>> differentiate which one it is for purpose of this patch.
> +1. And if we ever need to differentiate, we can always add them later, using
> code from systemd-detect-virt
> https://github.com/systemd/systemd/blob/master/src/basic/virt.c
> 
> Kind regards,
> Petr
> 

And while we're at it, let's also fix the buffer overflow in is_xen()
and make try_systemd_detect_virt() public. I'll send a patch.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
