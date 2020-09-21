From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 21 Sep 2020 19:11:50 +0530
Subject: [LTP] [PATCH 2/2] runtest/quickhit: Remove
In-Reply-To: <20200921115910.GA1993@dell5510>
References: <20200921114026.11184-1-chrubis@suse.cz>
 <20200921114026.11184-2-chrubis@suse.cz>
 <20200921115910.GA1993@dell5510>
Message-ID: <CA+G9fYs-ryAws0TuVngZ8-V1XhAh3hiEZT28nx8fNHdaeVQJkg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 21 Sep 2020 at 17:29, Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Cyril,
>
> > The file wasn't properly maintained for last ten years, 99% of the
> > patches touching it were only removing removed tests. We should stop
> > pretending that it's useful anyhow it clearly does not contain well
> > selected set of tests for quick testrun anymore.

We have been using quickhit as a smoke test across all available devices
because it runs in a minute. With this file removed what could be the next best
tests for a quick smoke test ?

Since we are using and testing this quickhit shall we keep it ?

>
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > CC: "Bird, Tim" <Tim.Bird@sony.com>
> > CC: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>

- Naresh

> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
