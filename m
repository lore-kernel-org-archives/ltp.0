From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 15 Apr 2020 14:07:30 +0200
Subject: [LTP] [PATCH V2 1/2] tst_timer: Add time64 related helpers
In-Reply-To: <20200415115234.GD12705@rei.lan>
References: <cover.1586861885.git.viresh.kumar@linaro.org>
 <0b30a19ac2938561f6e5e8e3264528aad6e42a76.1586861885.git.viresh.kumar@linaro.org>
 <20200415115234.GD12705@rei.lan>
Message-ID: <CAK8P3a2cwb1Lh5nJ4DRdDF4ADnON5axRkxUR+g4impceqbHABw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Apr 15, 2020 at 1:52 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > This introduces a new set of helpers to handle the time64 related
> > timespec. Instead of duplicating the code, this moves the existing code
> > into a macro and then defines timespec and time64 related helpers using
> > it.
>
> I'm not sure that adding a macro that spans over ~150 lines is a good
> idea. Unfortunately there is not so much options for a C language that
> lacks generics.
>
> Maybe it would be slightly better to write a shell script that would
> generate these defintions into a separate header that would be included
> in the tst_timer.h. That way we can run it manually to regenerate the
> header if needed. At least we would get saner error message from
> compiler that way.

How about having a shared .c file that is built multiple times with different
sets of -DBUILD_FOO options set from the Makefile, and a small
number of #ifdefs inside that file?

      Arnd
