From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 8 Mar 2019 03:08:48 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/fanotify0[135]: contain effects of
 FAN_MARK_MOUNT|FILESYSTEM to test device
In-Reply-To: <CAOQ4uxiEbZkw-y0sMeE8t2G6e2Wu51eLWcNANtFVNiqr+jkxjQ@mail.gmail.com>
References: <3b298cac8fd8516df09a761c3eaf8538f0b5049c.1551779182.git.jstancek@redhat.com>
 <CAOQ4uxiEbZkw-y0sMeE8t2G6e2Wu51eLWcNANtFVNiqr+jkxjQ@mail.gmail.com>
Message-ID: <671345018.6037235.1552032528659.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Tue, Mar 5, 2019 at 11:50 AM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > FAN_MARK_MOUNT|FILESYSTEM can set up monitoring for entire root /, which
> > can lead to interference from other background processes.
> >
> > Use separate device/mount to isolate events from tests.
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Thanks!

Pushed.

Regards,
Jan
