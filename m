From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 20 Aug 2020 22:57:06 +0800
Subject: [LTP] [PATCH v3 1/1] tst_kvcmp: Strip double quotes when
 parsing /etc/os-release
In-Reply-To: <20200820134557.GG9000@yuki.lan>
References: <20200820133032.16840-1-pvorel@suse.cz>
 <20200820134557.GG9000@yuki.lan>
Message-ID: <CAMy_GT_0yg4CEW+a8TC-9rrYeNWW0Xa+UsMa70v495WBrUXeBA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

LGTM,
Tested with crafted ID, it can correctly parse the ID with or without
the double quote.

Another thing to note is that I found the loop in tst_kvercmp2 could
iterate outside the size of "vers" and causing
tst_test.c:1298: BROK: Test killed by SIGSEGV!

Reviewed-by: Po-Hsu Lin <po-hsu.lin@canonical.com>

On Thu, Aug 20, 2020 at 9:45 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Looks good to me.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>
> --
> Cyril Hrubis
> chrubis@suse.cz
