From: David Hu <xuehaohu@google.com>
Date: Thu, 8 Jul 2021 14:22:50 -0400
Subject: [LTP] Existing kexec tests
In-Reply-To: <YObGwky3Nb6cN6R6@yuki>
References: <CAPd9Lg-feW5KF=BDUzfGnqZPYs4S4ypBemb3b=qgG2z-9YsCiw@mail.gmail.com>
 <YObGwky3Nb6cN6R6@yuki>
Message-ID: <CAPd9Lg-1zDJXbKYb_veAGaR78MXgTiAUZ3jm-WVneo25EcWs2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
   I am starting from scratch trying to come up with tests for kexec, so
there is not a
   specific framework I am working with now. any pointers / examples I can
look into
   to get a kexec test up on top of LTP ?

   The motivation is to improve kexec to address issues from this list
https://docs.google.com/document/d/1cbTOapDAA1MfDSS5bggvEGcqNCFsrsFnAM2xX1wsOnk/edit?ts=60ca3192#heading=h.4gti11dn65un

thanks,

--------
David

This email may be confidential or privileged. If you received this
communication by mistake, please don't forward it to anyone else, please
erase all copies and attachments, and please let me know that it went to
the wrong person. Thank you.


On Thu, Jul 8, 2021 at 6:00 AM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I am looking existing tests that cover kexec (kexec_load and
> > kexec_file_load across LTS versions , platforms, etc)
> >
> > wondering if there are existing tests already ?
>
> I do not think that we do have anything working in LTP, the main problem
> here is that it has to be communicated to the test framework that these
> tests will reboot the machine under test, which is not easy task.
>
> So at this point I guess that it mostly depends on which framework you
> are using and if there are kexec tests available for it.
>
> The long term plan is to communicate such metadata in a json format from
> the test to the framework in a framework independed way, which should
> enable us for including all kinds of tests that need to reboot the SUT
> in LTP.
>
> Also CCying automated-testing ML.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210708/728c4763/attachment-0001.htm>
