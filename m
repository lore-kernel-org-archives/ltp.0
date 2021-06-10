From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Jun 2021 09:22:22 +0200
Subject: [LTP] [PATCH] lib/tst_virt.c: Add fallback when not using
 Microsoft Hyper-V hypervisor
In-Reply-To: <1623297725-3296-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1623297725-3296-1-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <YMG9rm9OlnY98Yba@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If we don't use Microsoft Hyper-V hypervisorm, getrusage04 will report the
> following error:
> getrusage04    1  TBROK  :  tst_virt.c:175: invalid virt_type flag: 6
> getrusage04    2  TBROK  :  tst_virt.c:175: Remaining cases broken
> 
> We should add is_hyperv() function when try_systemd_detect_virt returns -1.
> But it is a bit complexd according to systemd-detect-virt implementation[1].
> Microsoft Hyper-V hypervisor detection has been introduced since long time ago,
> most system should support it.

Sorry for missing this, Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
