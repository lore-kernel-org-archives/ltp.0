From: Li Wang <liwang@redhat.com>
Date: Thu, 7 May 2020 15:59:36 +0800
Subject: [LTP] [PATCH] pty04: Correct struct member sizes and add to CVE
 runtest file
In-Reply-To: <20200506171921.GA1214@dell5510>
References: <20200506170407.5562-1-rpalethorpe@suse.com>
 <20200506171921.GA1214@dell5510>
Message-ID: <CAEemH2eQ9Dd4CewEvPxfZx-1R69QS990iodR1_EsbYBVX8TmyA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, May 7, 2020 at 1:19 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Richard,
>
> > Also remove min_kver because it is arbitrary. We know this test works on
> much
> > older kernels, but it will probably hit bugs that have been fixed for a
> long
> > time.
>
> Thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Waiting for reactions to .min_kver removal.
>

Removing .min_kver = "4.10" is fine by me, it works on rhel6/7/8 from my
test. The test failure seems related to the unfix kernel problem.

nit: I might separate runtest change into it's own commit.
>

Also to add #define CAN_MTU     (sizeof(struct can_frame)).


> Kind regards,
> Petr
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200507/b415096e/attachment.htm>
