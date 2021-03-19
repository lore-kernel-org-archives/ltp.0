From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 19 Mar 2021 15:54:02 +0200
Subject: [LTP] [PATCH 0/8] fanotify tests for v5.13
In-Reply-To: <YFShR2Qd7Ubve1wi@pevik>
References: <20210318131134.3562203-1-amir73il@gmail.com>
 <YFShR2Qd7Ubve1wi@pevik>
Message-ID: <CAOQ4uxhLOqfarhXa-mnPnUtSXVUr1cpz79bm3TE6c5=4oo-Eeg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 19, 2021 at 3:04 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Amir,
>
> > Hi Petr,
>
> > Following tests were used for development of the two features
> > queued for v5.13 (in linux-next):
> > - Performance improvements for events merge [1]
> > - Unprivileged fanotify listener [2]
>
> As these are features not fixes, I suppose nothing from these already merged 2
> patchsets in next tree can be added with struct tst_tag to document it.
> I wonder if any of these are could be at least noted in the tests / commit
> messages.
>

Whatever you think is best for your project users.
If you want to document the commits that added the features, I suggest
that you wait until those commits hit master (next cycle).
These are the relevant commit subjects:

   fanotify: configurable limits via sysfs
   fanotify: support limited functionality for unprivileged users

Thanks,
Amir.
