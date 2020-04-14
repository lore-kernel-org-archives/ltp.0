From: Li Wang <liwang@redhat.com>
Date: Tue, 14 Apr 2020 17:46:51 +0800
Subject: [LTP] LTP testcase analysis
In-Reply-To: <MAXPR0101MB14680DF141378F7038F0CA88EEDA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14684E021A23A6B00ED69DC0EEDA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
 <CAEemH2dB5tz-GMoFzRniQhtBJyDg9wfGoEWZSBU2Nz=e14jeiw@mail.gmail.com>
 <MAXPR0101MB14680DF141378F7038F0CA88EEDA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <CAEemH2ff696xw1WcGW9CcvPy0X4E5WnD1xtZ=kFXZ2y1_sCFaQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Pankaj,

[We'd better cc LTP ML to regard everyone on the list :), this is the way
upstream working in]

I mean you'd better provide the test log(i.e. oom01,futex_wait05, select04)
which output to your console, people need to read the message before
analysis problem at least.

On Tue, Apr 14, 2020 at 5:26 PM Pankaj Vinadrao Joshi <
Pankaj.VJ@exaleapsemi.com> wrote:

> Hi,
> Want kind of log can help us to resolve??Because not only this x86 i found
> same kind of issue on other arch also...if its happening like so whether we
> should consider that test as validated or not?
>
> Thanks!
> ------------------------------
> *From:* Li Wang <liwang@redhat.com>
> *Sent:* Tuesday, April 14, 2020 2:52 PM
> *To:* Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
> *Cc:* Yang Xu <xuyang2018.jy@cn.fujitsu.com>; Cyril Hrubis <
> chrubis@suse.cz>; ltp@lists.linux.it <ltp@lists.linux.it>
> *Subject:* Re: [LTP] LTP testcase analysis
>
> Hi Pankaj,
>
> On Tue, Apr 14, 2020 at 4:45 PM Pankaj Vinadrao Joshi <
> Pankaj.VJ@exaleapsemi.com> wrote:
>
> Hi,
> i am running LTP on x86 with 5.4.3 kernel.i gave $ ./runltp command to run
> the complete LTP but found some failures,like oom01,futex_wait05,select04
> etc.
>
> When i tried to run single test some of them turns into PASS which earlier
> got failed.like oom01 was failed then i gave coomand $./runltp -s oom01 and
> after that it got pass.
>
> why it could be happened,any specific reason,if you know please suggest??
>
>
> I understand sometimes test failures depress us but, it's impossible to
> know what happened without any detailed test log provided:).
>
> --
> Regards,
> Li Wang
> [EXT]
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200414/003b91ef/attachment.htm>
