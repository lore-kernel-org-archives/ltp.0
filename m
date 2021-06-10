From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Thu, 10 Jun 2021 08:12:51 +0000
Subject: [LTP] [PATCH] lib/tst_virt.c: Add fallback when not using
 Microsoft Hyper-V hypervisor
In-Reply-To: <YMHF/H7OsORVP606@pevik>
References: <1623297725-3296-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <121d371d-baca-fc43-9938-8d83e360d97b@canonical.com> <YMHF/H7OsORVP606@pevik>
Message-ID: <60C1C99B.6070107@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All
Thanks for your review. I have merged this patch with correcting two typos.

Best Regards
Yang Xu
> Hi all,
>
>> On 10/06/2021 06:02, Yang Xu wrote:
>>> If we don't use Microsoft Hyper-V hypervisorm, getrusage04 will report the
>
>> s/hypervisorm/hypervisor/
> +1
>
>>> following error:
>>> getrusage04    1  TBROK  :  tst_virt.c:175: invalid virt_type flag: 6
>>> getrusage04    2  TBROK  :  tst_virt.c:175: Remaining cases broken
>
>>> We should add is_hyperv() function when try_systemd_detect_virt returns -1.
>>> But it is a bit complexd according to systemd-detect-virt implementation[1].
>
>> s/complexd/complex/
> +1
>
> Thanks!
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> Kind regards,
> Petr
