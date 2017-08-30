From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Aug 2017 09:06:19 +0200
Subject: [LTP] [PATCH v2] android: pty01: Fix pty01 test for Android.
In-Reply-To: <CAJgzZoqWAFonKprb2rWEXj47mus52Mj_kYtoFhu9EJ5sCkqUeA@mail.gmail.com>
References: <20170829002637.25643-1-sspatil@google.com>
 <20170829090825.lgjzm5kqnnbhldhr@dell5510>
 <CAJgzZoqWAFonKprb2rWEXj47mus52Mj_kYtoFhu9EJ5sCkqUeA@mail.gmail.com>
Message-ID: <20170830070619.34ejq2ohqqijmpbz@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > I wonder, whether it's really better to use __BIONIC__ instead of __ANDROID__ (works with
> > both), but assume it is if it's really bionic specific.

> yeah, grantpt unconditionally does nothing in bionic, regardless of
> whether you're running on an Android device or a desktop/server Linux
> box.
OT: I didn't think there would be any use of bionic apart from Android (e.g. Linux /BSD
distro using it), but there is one project (not very active now):
https://github.com/gentoobionic/bionic


Kind regards,
Petr
