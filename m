From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Dec 2017 18:34:39 +0530
Subject: [LTP] [PATCH] runltp: skipfile: skipped test cases should be
 visible as TCONF in results
In-Reply-To: <20171220102830.GB6688@rei>
References: <1513073830-17174-1-git-send-email-naresh.kamboju@linaro.org>
 <20171219125952.GE28293@rei>
 <CA+G9fYv4DnCufg6xofpjuM7S8zt1mzRtE4VfrP=PaNF5fxiy1w@mail.gmail.com>
 <20171220102830.GB6688@rei>
Message-ID: <CA+G9fYuhvG4ymur868HJE8fH=qMGPDR2KWnhP3RJh9XKGbUx=w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20 December 2017 at 15:58, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> > This could be written in a simpler form:
>> >
>> >         for test_name in $(awk '{print $1}' "$SKIPFILE"); do
>> >                 case "${test_name}" in \#*) continue;; esac
>> >                 sed -i "/\<${test_name}\>/c\\${test_name} exit 32;" alltests
>> >         done
>>
>> I have tested this piece of script and this also works.
>> Shall i re-send the patch with this modification ?
>
> Yes please.

Sending updated patch with above comments.
- Naresh

>
> --
> Cyril Hrubis
> chrubis@suse.cz
