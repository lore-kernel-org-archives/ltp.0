From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Dec 2017 11:28:30 +0100
Subject: [LTP] [PATCH] runltp: skipfile: skipped test cases should be
 visible as TCONF in results
In-Reply-To: <CA+G9fYv4DnCufg6xofpjuM7S8zt1mzRtE4VfrP=PaNF5fxiy1w@mail.gmail.com>
References: <1513073830-17174-1-git-send-email-naresh.kamboju@linaro.org>
 <20171219125952.GE28293@rei>
 <CA+G9fYv4DnCufg6xofpjuM7S8zt1mzRtE4VfrP=PaNF5fxiy1w@mail.gmail.com>
Message-ID: <20171220102830.GB6688@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This could be written in a simpler form:
> >
> >         for test_name in $(awk '{print $1}' "$SKIPFILE"); do
> >                 case "${test_name}" in \#*) continue;; esac
> >                 sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
> >         done
> 
> I have tested this piece of script and this also works.
> Shall i re-send the patch with this modification ?

Yes please.

-- 
Cyril Hrubis
chrubis@suse.cz
