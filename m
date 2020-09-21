From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 21 Sep 2020 19:15:08 +0530
Subject: [LTP] [PATCH 2/2] runtest/quickhit: Remove
In-Reply-To: <CA+G9fYs-ryAws0TuVngZ8-V1XhAh3hiEZT28nx8fNHdaeVQJkg@mail.gmail.com>
References: <20200921114026.11184-1-chrubis@suse.cz>
 <20200921114026.11184-2-chrubis@suse.cz>
 <20200921115910.GA1993@dell5510>
 <CA+G9fYs-ryAws0TuVngZ8-V1XhAh3hiEZT28nx8fNHdaeVQJkg@mail.gmail.com>
Message-ID: <CA+G9fYt5QJ334V+j80TA_NONQQHd1ji23Fy1y28JNMFjXSw_9w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 21 Sep 2020 at 19:11, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Mon, 21 Sep 2020 at 17:29, Petr Vorel <pvorel@suse.cz> wrote:
> >
> > Hi Cyril,
> >
> > > The file wasn't properly maintained for last ten years, 99% of the
> > > patches touching it were only removing removed tests. We should stop
> > > pretending that it's useful anyhow it clearly does not contain well
> > > selected set of tests for quick testrun anymore.
>
> We have been using quickhit as a smoke test across all available devices
> because it runs in a minute. With this file removed what could be the next best
> tests for a quick smoke test ?
>

I got the answer to my question on other patch adding smoketest

runtest/smoketest: Add smoketest

> Since we are using and testing this quickhit shall we keep it ?

- Naresh
