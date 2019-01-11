From: Li Wang <liwang@redhat.com>
Date: Fri, 11 Jan 2019 13:57:19 +0800
Subject: [LTP] [PATCH v2] Check recvmmsg exists before entering fuzzy
	loop
In-Reply-To: <20190110095950.21689-1-rpalethorpe@suse.com>
References: <CAEemH2cRO5PytjrqvFjCnUji+XQ7KeaXua+DDzxOT7Eu3+Wd2A@mail.gmail.com>
 <20190110095950.21689-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2cfoYu1V=6QQFGxHRBWOK7gNLK8EAnrvNezCzN_rkx_wQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jan 10, 2019 at 6:00 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
> Avoid thread B entering infinite loop if recvmmsg doesn't exist causing
> tst_brk to be called and thread A to make an ungraceful exit.
>
> A more general fix can be added to tst_fuzzy_sync as well, but will take
> longer to develop.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reported-by: Li Wang <liwang@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
