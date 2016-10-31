From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 12:14:05 +0100
Subject: [LTP] Test Results
In-Reply-To: <CAAQtLgPCdPKEtSn4RDcPvu3xs=vaXkT6fSZRF7viCZm=eA9N9Q@mail.gmail.com>
References: <CAAQtLgPCdPKEtSn4RDcPvu3xs=vaXkT6fSZRF7viCZm=eA9N9Q@mail.gmail.com>
Message-ID: <20161031111404.GF30590@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> At first, I want to know how do you store and how do you receive test
> results? What is it? Some files like xml or JSON? Could you please
> describe it better because I want to know your experience to reproduce
> it in some cases in my project to make it better.

The LTP run produces plain old text files, the result file is created in
results/ directory with testcase name and test result on a single line,
then there are two more files one for a list of failed tests and one for
list of skipped tests so that you don't have to grep the result file
every time you want to get the list of failed tests.

-- 
Cyril Hrubis
chrubis@suse.cz
