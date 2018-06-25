From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jun 2018 16:06:01 +0200
Subject: [LTP] Usage of tst_parse and Emailing results
In-Reply-To: <CA+Kjy2wgaiMYOJX5FoOsP8f=WyDadRBJR9sfkghcUEhne4-PFQ@mail.gmail.com>
References: <CA+Kjy2wgaiMYOJX5FoOsP8f=WyDadRBJR9sfkghcUEhne4-PFQ@mail.gmail.com>
Message-ID: <20180625140601.GC24288@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have a requirement to run a test case along with device  address from
> command line, for eg., running an i2c test  as follows
> 
>  i2c_test <device addr>
> 
> How could I make use of tst_parse() to get device addr, please suggest with
> examples.

There is no tst_parse() function in LTP.

Documentation and example on how to pass parameters to a test is at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#225-test-specific-command-line-options

> Also I wanted to send test results to email id on completion of test
> execution, please update me if I need to add any code snippet in test code
> or from command line configuration. Please suggest.

What exactly are you trying to do here?

It's not clear what "completion of test execution" means.

The runltp script has an option to send a email with results but you
have to install and configure mutt beforehand.

-- 
Cyril Hrubis
chrubis@suse.cz
