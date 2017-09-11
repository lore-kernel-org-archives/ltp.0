From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 11 Sep 2017 23:41:50 +0200
Subject: [LTP] [RFC PATCH 1/6] android: cve: Disable building
 cve-2017-5669
In-Reply-To: <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-2-petr.vorel@gmail.com>
 <20170905213027.GP84377@sspatil-desktop.mtv.corp.google.com>
Message-ID: <20170911214149.4ongogs2asatw454@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> Do you have pointers to how you are build + testing with this? There seem to
> be some duplication of effort that I would like to avoid and make sure there
> is only 1 way in which tests like this are disabled out of build.

> I am currently working through a list[1] of disabled tests to make sure
> nothing has changed and will love to have a unified way of maintaining that
> list instead of doing it out-of-tree.

> - ssp

> 1. https://android.googlesource.com/platform/external/ltp/+/master/android/tools/disabled_tests.txt

Great, it'd be nice to have working Android build (and not just everything disabled).
Nice list, thanks for sharing.

BTW do you build with standalone toolchain? Which API level are you going to support?
https://android.googlesource.com/platform/ndk/+/master/build/tools/make-standalone-toolchain.sh


Kind regards,
Petr
