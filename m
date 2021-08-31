From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 31 Aug 2021 08:09:34 +0200
Subject: [LTP] [RFC PATCH 1/1] scripts: Remove legacy script tests
In-Reply-To: <YSzYSkufvSNNwZQP@yuki>
References: <20210827123254.16883-1-pvorel@suse.cz> <YSjhgaJE3v8odUhF@pevik>
 <YSzYSkufvSNNwZQP@yuki>
Message-ID: <YS3Hnn6b4QAWAaPa@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > and I suppose, we could remove also detect_distro.sh (we have lsb-release
> > nowadays) and git2changelog.sh (we write release notes manually).

> Looks good.
Thanks, merged!

I'll send another patch to remove detect_distro.sh and git2changelog.sh.

Kind regards,
Petr
