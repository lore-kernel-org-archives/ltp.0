From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 30 Apr 2019 10:51:20 -0400 (EDT)
Subject: [LTP] TST_BRK_SUPPORTS_ONLY_TCONF_TBROK() error message
In-Reply-To: <20190430144346.GA16914@dell5510>
References: <20190430144346.GA16914@dell5510>
Message-ID: <279785141.20224513.1556635880484.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan,
> 
> your commit 0738e3753 ("lib: build check parameters for tst_brk()") added
> check
> for invalid types. I guess we didn't find a way how to print meaningful error

Correct - at least not something that would work easily across all
compilers types/versions.

> message e.g. "tst_brk(): invalid type, please use TBROK/TCONF/TFAIL" as Xiao
> suggested [1]. Because error message on tst_brk(TINFO, "foo") is a bit
> confusing:
> 
> ../../../../include/tst_common.h:69:25: error: size of unnamed array is
> negative
>   do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)
> 
> (this is not related to current release effort)
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/comment/2026378/
> 
> 
