From: enh <enh@google.com>
Date: Wed, 30 Aug 2017 08:07:15 -0700
Subject: [LTP] [PATCH v2] android: pty01: Fix pty01 test for Android.
In-Reply-To: <20170830070619.34ejq2ohqqijmpbz@x230>
References: <20170829002637.25643-1-sspatil@google.com>
 <20170829090825.lgjzm5kqnnbhldhr@dell5510>
 <CAJgzZoqWAFonKprb2rWEXj47mus52Mj_kYtoFhu9EJ5sCkqUeA@mail.gmail.com>
 <20170830070619.34ejq2ohqqijmpbz@x230>
Message-ID: <CAJgzZoq=dW8+U7R6Hybu69phdehnzC63kj1scXxrXO7Up=_d=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 30, 2017 at 12:06 AM, Petr Vorel <pvorel@suse.cz> wrote:
> Hi,
>
>> > I wonder, whether it's really better to use __BIONIC__ instead of __ANDROID__ (works with
>> > both), but assume it is if it's really bionic specific.
>
>> yeah, grantpt unconditionally does nothing in bionic, regardless of
>> whether you're running on an Android device or a desktop/server Linux
>> box.
> OT: I didn't think there would be any use of bionic apart from Android (e.g. Linux /BSD
> distro using it), but there is one project (not very active now):
> https://github.com/gentoobionic/bionic

we're moving towards it internally for more hermetic builds, which is
why we've been running in to a lot of these lately. historically
almost no-one ever made a distinction, and almost always chose
__ANDROID__ for some reason. (even though __linux__ and __BIONIC__ are
usually the more accurate choices.)

> Kind regards,
> Petr
