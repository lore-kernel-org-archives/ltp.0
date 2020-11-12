From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 12 Nov 2020 15:57:24 +0100
Subject: [LTP] [PATCH v3 1/2] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <20201112142146.GA19824@yuki.lan>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201112142146.GA19824@yuki.lan>
Message-ID: <2c091ecd-af38-2569-5fd4-a1f3e3458a01@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12. 11. 20 15:21, Cyril Hrubis wrote:
> Hi!
> I've looked into the library and what it actually does in this case is
> that it opens a sysfs file and reads a few bytes from there. I guess
> that we can even avoid linking the library in this case, since we just
> want to know a value of the single bit in the SecureBoot file.
> 
> The full path is:
> 
> /sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c

Yes, we could read the sysfile directly. But do we want to deal with
potential compatibility issues and test breakage if the UEFI vars API
changes in the future? The binary format of those sysfiles is controlled
by the UEFI Forum, not by kernel devs. The efivars library is available
on basically all modern distros and we most likely won't do any
SecureBoot tests on distros that don't have it.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
