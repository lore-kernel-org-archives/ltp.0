From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Jul 2021 11:34:58 +0200
Subject: [LTP] Existing kexec tests
In-Reply-To: <CAPd9Lg-feW5KF=BDUzfGnqZPYs4S4ypBemb3b=qgG2z-9YsCiw@mail.gmail.com>
References: <CAPd9Lg-feW5KF=BDUzfGnqZPYs4S4ypBemb3b=qgG2z-9YsCiw@mail.gmail.com>
Message-ID: <YObGwky3Nb6cN6R6@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I am looking existing tests that cover kexec (kexec_load and
> kexec_file_load across LTS versions , platforms, etc)
> 
> wondering if there are existing tests already ?

I do not think that we do have anything working in LTP, the main problem
here is that it has to be communicated to the test framework that these
tests will reboot the machine under test, which is not easy task.

So at this point I guess that it mostly depends on which framework you
are using and if there are kexec tests available for it.

The long term plan is to communicate such metadata in a json format from
the test to the framework in a framework independed way, which should
enable us for including all kinds of tests that need to reboot the SUT
in LTP.

Also CCying automated-testing ML.

-- 
Cyril Hrubis
chrubis@suse.cz
