From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 May 2020 07:29:36 +0200
Subject: [LTP] [PATCH V4 1/1] syscall: Add io_uring test
In-Reply-To: <20200515040849.yu27rdihdih5wxc3@vireshk-i7>
References: <20200514172831.27854-1-vikas.kumar2@arm.com>
 <20200514172831.27854-2-vikas.kumar2@arm.com>
 <20200515040849.yu27rdihdih5wxc3@vireshk-i7>
Message-ID: <20200515052936.GA5117@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 14-05-20, 22:58, Vikas Kumar wrote:
> > Added Linux asynchronous I/O API Test for io_uring_setup(),
> > io_uring_register() and io_uring_enter().
> > This test will check io_uring api basic operation.

> > Signed-off-by: Vikas Kumar <vikas.kumar2@arm.com>
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> Please don't do this unless someone gave you this explicitly.
+1. By this you say Cyril considered your patch ready, which is not true.
Just on a brief look I see there needed to be some changes.

Kind regards,
Petr
