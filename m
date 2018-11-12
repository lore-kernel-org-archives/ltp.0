From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Nov 2018 14:11:48 +0100
Subject: [LTP] [PATCH 1/1] syscalls/fanotify10: Require kernel v4.19
In-Reply-To: <CAOQ4uxjVnAUYfH8_fuHXruObt1WVqObHxQxLmCxcPCNL-S5PjQ@mail.gmail.com>
References: <20181106124802.27170-1-pvorel@suse.cz>
 <20181106125015.GB4834@rei.lan> <20181106125556.GA28469@dell5510>
 <CAOQ4uxhd9XZj=zvkm1j8mZBkBRw0qhvfwcaRQKzs24bVjsfUZw@mail.gmail.com>
 <20181106130641.GB28469@dell5510>
 <CAOQ4uxjVnAUYfH8_fuHXruObt1WVqObHxQxLmCxcPCNL-S5PjQ@mail.gmail.com>
Message-ID: <20181112131148.GK3470@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > > Did I miss anything?
> > Testing your branch on older kernel, fanotify10 fails earlier than new TCONF

> Because fanotify10 checks for a bug that existed since the beginning
> and fixed by 9bdda4e9cf2d fsnotify: fix ignore mask logic in fsnotify().
> So test SHOULD fail until the backported patch is applied to the old kernel.

> The patch does not apply cleanly to kernels <= v4.17.
> Tested backport patch for v4.14.y attached.

Thanks for info and Cc us for your patch in kernel.

> Thanks,
> Amir.
Kind regards,
Petr
