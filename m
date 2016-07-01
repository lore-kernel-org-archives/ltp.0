From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 1 Jul 2016 07:16:04 -0400 (EDT)
Subject: [LTP] [PATCH] fanotify06: create a mount for test
In-Reply-To: <20160629195040.GA16831@quack2.suse.cz>
References: <7ef37bcfb79c3fa81182e6530e5a0f3a35aacdad.1467190006.git.jstancek@redhat.com>
 <20160629195040.GA16831@quack2.suse.cz>
Message-ID: <1567220971.1417138.1467371764182.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Jan Kara" <jack@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it, jack@suse.cz
> Sent: Wednesday, 29 June, 2016 9:50:40 PM
> Subject: Re: [PATCH] fanotify06: create a mount for test
> 
> On Wed 29-06-16 10:49:11, Jan Stancek wrote:
> > This testcase can rarely fail, when there is a background process
> > modifying files on same mountpoint as is LTP's tmpdir:
> > 
> > fanotify06    1  TFAIL  :  fanotify06.c:212: group 0 got more than one
> > event (48 > 24)
> > fanotify06    2  TFAIL  :  fanotify06.c:212: group 1 got more than one
> > event (48 > 24)
> > fanotify06    3  TFAIL  :  fanotify06.c:212: group 2 got more than one
> > event (48 > 24)
> > fanotify06    4  TFAIL  :  fanotify06.c:222: group 3 got event
> > fanotify06    5  TFAIL  :  fanotify06.c:222: group 4 got event
> > fanotify06    6  TPASS  :  group 5 got no event
> > fanotify06    7  TPASS  :  group 6 got no event
> > fanotify06    8  TPASS  :  group 7 got no event
> > fanotify06    9  TPASS  :  group 8 got no event
> > 
> > This patch creates a mount, which should be only used by this
> > test to limit interference from rest of OS. It also adds missing
> > tst_require_root().
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Yeah, that is a good idea. The patch looks good to me so feel free to add:
> 
> Acked-by: Jan Kara <jack@suse.cz>
> 
> 								Honza

Pushed.

Regards,
Jan
