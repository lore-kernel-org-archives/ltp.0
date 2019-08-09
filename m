From: Li Wang <liwang@redhat.com>
Date: Fri, 9 Aug 2019 18:17:52 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: Fix #12 when TMPDIR
 is on tmpfs or ext[234]
In-Reply-To: <20190809094259.GA27030@dell5510>
References: <20190807094119.10834-1-pvorel@suse.cz>
 <CAEemH2cM7mhkYBvTTFC4UhjnYxG0D_e-nkCmSF2U8pB61UT0bw@mail.gmail.com>
 <20190809094259.GA27030@dell5510>
Message-ID: <CAEemH2dmQsq7EuN0UqWJuuomQxPXF2Rh_O-EQyW9r4vTHbdpjA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 9, 2019 at 5:43 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> > Or, anything else?
>
> How about try errno for latest kernel for any kernel (in case it has been
> backported) and if not do the check based on kernel version?
> Probably combined with TWARN.

To combine the methods(1 and 2) together sounds good. But not sure if
that could be a formal policy/rule for LTP. We need some more
thinking/comments.

-- 
Regards,
Li Wang
