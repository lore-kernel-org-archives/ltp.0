From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Sep 2017 10:04:44 +0200
Subject: [LTP] LTP release and code freeze
In-Reply-To: <CA+G9fYs59g3eHyucNRJQ1+vxmwykZ_hHaUbANREpHXJ9C9u=TQ@mail.gmail.com>
References: <CA+G9fYs59g3eHyucNRJQ1+vxmwykZ_hHaUbANREpHXJ9C9u=TQ@mail.gmail.com>
Message-ID: <20170919080444.GA14080@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Regarding the LTP September 2017 release,
> Identifying bugs / issues / limitation / pre-requirements of LTP
> testing on ARM64 architecture is crucial at our end. We would like to
> test LTP pre-release candidate on ARM64 architecture.
> Please announce code freeze and allow time to validate test code.

I guess that you can start with the validation now. We haven't declared
the freeze formally yet, but there are only a few possible changes that
may get in the release. The thp01 is broken on new kernels, that one
should get in for sure. Then possibly something like ten tests may end
up affected by possible changes in the CVE tests, which should be easy
enough to retest if needed.

-- 
Cyril Hrubis
chrubis@suse.cz
