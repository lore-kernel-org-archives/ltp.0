From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 22 Mar 2021 20:42:26 +0200
Subject: [LTP] [PATCH 0/8] fanotify tests for v5.13
In-Reply-To: <YFeo7vI58VMA6W7a@pevik>
References: <20210318131134.3562203-1-amir73il@gmail.com>
 <YFShR2Qd7Ubve1wi@pevik>
 <CAOQ4uxhLOqfarhXa-mnPnUtSXVUr1cpz79bm3TE6c5=4oo-Eeg@mail.gmail.com>
 <YFeo7vI58VMA6W7a@pevik>
Message-ID: <CAOQ4uxjWTKncGxcOfT9XJ8REXZt9fdB7QsWRT74hUrB8mkNg-Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Mar 21, 2021 at 10:13 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > Whatever you think is best for your project users.
> > If you want to document the commits that added the features, I suggest
> > that you wait until those commits hit master (next cycle).
> > These are the relevant commit subjects:
>
> >    fanotify: configurable limits via sysfs
> >    fanotify: support limited functionality for unprivileged users
>
> Thanks a lot!
> IMHO being in next tree should be ok (commits hashes should be kept).
>

There is no such guarantee, certainly not so far from the v5.13 merge
window, so I advise against including the commit ids at this point.
The commit subject is descriptive enough IMO and you can add commit
ids later on if you think it is necessary.

Thanks,
Amir.
