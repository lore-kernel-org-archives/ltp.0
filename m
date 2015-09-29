From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 29 Sep 2015 14:25:27 +0200
Subject: [LTP] membarrier test-case?
In-Reply-To: <CA+icZUXpsYL6d+DkN2Np0d=EpP3a5C2uoyc-Bz2UX0KhKtRTyA@mail.gmail.com>
References: <CA+icZUUi_yNcy8pwk0nzctar_pWHrrm0EViV4sAfXr2oM=kYng@mail.gmail.com>
 <20150929091650.GA24796@rei.suse.cz>
 <CA+icZUXpsYL6d+DkN2Np0d=EpP3a5C2uoyc-Bz2UX0KhKtRTyA@mail.gmail.com>
Message-ID: <20150929122526.GB30371@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > No. The membarrier syscall is not part of any officially released kernel
> > yet. Once it gets released and once somebody has time to look into it we
> > may add testcases for it into LTP.
> >
> 
> So, wait for Linux v4.3.

Yes, things tend to change during rc phase so we don't adapt LTP until
the changes are final.

-- 
Cyril Hrubis
chrubis@suse.cz
