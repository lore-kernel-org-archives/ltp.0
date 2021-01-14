From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 14 Jan 2021 10:17:22 +0100
Subject: [LTP] Holidays and LTP release
In-Reply-To: <X/Wq28noppvB5MGw@yuki.lan>
References: <X9tMlNxJbwCWIRnO@yuki.lan> <X/Wq28noppvB5MGw@yuki.lan>
Message-ID: <08823579-efa5-4f3c-c718-caac14c10c15@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 06. 01. 21 13:19, Cyril Hrubis wrote:
> Hi!
> As you may noticed I'm back and I'm trying to review anything that
> should be considered for the release.
> 
> Please let me know if there is anything I should look into.

Can we add the tst_secureboot_enabled() patchset to the new release? It
fixes lockdown detection issues on some kernels and it shouldn't affect
anything except the iopl/ioperm syscall tests.
https://patchwork.ozlabs.org/project/ltp/list/?series=223859

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
