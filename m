From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 30 Apr 2019 16:43:46 +0200
Subject: [LTP] TST_BRK_SUPPORTS_ONLY_TCONF_TBROK() error message
Message-ID: <20190430144346.GA16914@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

your commit 0738e3753 ("lib: build check parameters for tst_brk()") added check
for invalid types. I guess we didn't find a way how to print meaningful error
message e.g. "tst_brk(): invalid type, please use TBROK/TCONF/TFAIL" as Xiao
suggested [1]. Because error message on tst_brk(TINFO, "foo") is a bit
confusing:

../../../../include/tst_common.h:69:25: error: size of unnamed array is negative
  do { ((void)sizeof(char[1 - 2 * !!(condition)])); } while (0)

(this is not related to current release effort)

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/comment/2026378/

