From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 9 Jul 2021 10:40:23 +0200
Subject: [LTP] Existing kexec tests
In-Reply-To: <CAPd9Lg-1zDJXbKYb_veAGaR78MXgTiAUZ3jm-WVneo25EcWs2g@mail.gmail.com>
References: <CAPd9Lg-feW5KF=BDUzfGnqZPYs4S4ypBemb3b=qgG2z-9YsCiw@mail.gmail.com>
 <YObGwky3Nb6cN6R6@yuki>
 <CAPd9Lg-1zDJXbKYb_veAGaR78MXgTiAUZ3jm-WVneo25EcWs2g@mail.gmail.com>
Message-ID: <YOgLd8W1qbNtisi0@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>    I am starting from scratch trying to come up with tests for kexec, so
> there is not a
>    specific framework I am working with now. any pointers / examples I can
> look into
>    to get a kexec test up on top of LTP ?
> 
>    The motivation is to improve kexec to address issues from this list
> https://docs.google.com/document/d/1cbTOapDAA1MfDSS5bggvEGcqNCFsrsFnAM2xX1wsOnk/edit?ts=60ca3192#heading=h.4gti11dn65un

The problems with kexec() (and similar tests) are twofold.

First of all we have to prepare the environment correctly, i.e. find
kernel image and initrd and so on. This varies a lot between
distributions but it's still the easier part.

Secondly the test execution framework has to be aware of the fact that
particular test reboots the machine and has to be able to handle the
situation gracefully. I've been putting the pieces together for last few
years and we are quite close to a generic solution. Let me try to describe
what we have in LTP so far.

First piece of the puzzle is a way to make the execution framework aware
of the fact that a particular test causes a reboot. At this point LTP
produces JSON file at build with various metadata parsed from the C
testcases, see the docparse/ directory in the LTP tree. So in this case
we would have to add a .reboots_machine flag to the tst_test structure
in the include/tst_test.h and the metadata parser will include it in the
metadata.json file if set in the test.

Second piece is a testruner that is able to run on a server in a lab so
that it's not taken down by the reboot. I've been working on
runltp-ng[1] for quite some time and I hope to include it in the LTP git
soon enough.

Third piece is to make use of the metadata in the testrunner. Generally
the runltp-ng would extract the metadata file from the machine that is
under the test as it does for rest of the files and load it. This is so
far missing, but should be quite easy as most of the infrastructure is
in place. I need this for different purposes as well, but so far I
haven't had time write the code.

Finally once third piece is in place the testrunner can check the
reebots_machine flag in the JSON before executing a test and if it's set
it would expect the machine to close connections and come up again.
Again if not all most of the infrastructure is in place since runltp-ng
can wait for machine to boot already.

[1] https://github.com/metan-ucw/runltp-ng

-- 
Cyril Hrubis
chrubis@suse.cz
