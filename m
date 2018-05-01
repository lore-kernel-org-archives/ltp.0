From: Steve Muckle <smuckle.linux@gmail.com>
Date: Tue, 1 May 2018 13:41:13 -0700
Subject: [LTP] [PATCH RESEND] syscalls/swapon03: do not fail if
 /proc/swaps is absent
In-Reply-To: <20180430112018.vb77fsqjzwi4aes4@dell5510>
References: <20180429220615.1206-1-smuckle.linux@gmail.com>
 <20180430112018.vb77fsqjzwi4aes4@dell5510>
Message-ID: <CAFdp1p2JB0zxSZQ_KB5COFZkiHXUp5a_T6teNz=41oJ=XPALrw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Apr 30, 2018 at 4:20 AM, Petr Vorel <pvorel@suse.cz> wrote:

> BTW I wonder which distros don't have CONFIG_SWAP=y. Some embedded or
> Android?
>

Thanks. Yes the platform in my case is Android, though I could see other
embedded platforms not using swap also.

cheers,
Steve
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180501/4fcb1c2d/attachment.html>
