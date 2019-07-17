From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jul 2019 16:08:53 +0800
Subject: [LTP] [PATCH v5 2/2] pkey: add test for memory protection keys
In-Reply-To: <20190709142426.GA6920@rei.lan>
References: <20190701081917.32051-1-liwang@redhat.com>
 <20190701081917.32051-2-liwang@redhat.com>
 <20190709142426.GA6920@rei.lan>
Message-ID: <CAEemH2fA6Xxhqbb7pJ1G3ChFbtzOueNpfzqP3EDnx9kq6LMpDQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jul 9, 2019 at 10:24 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> Looks good, some minor comments below.
>

Thanks! Pushed with the following changes:

1. add .needs_tmpdir = 1 in test struct
2. remove SAFE_MKDIR/SAFE_MOUNT from setup()
3. remove cleanup() function
4. take use of tst_no_corefile()
5. adjust the status content printing
6. adjust the code indent for switch case

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190717/e7d20549/attachment.htm>
