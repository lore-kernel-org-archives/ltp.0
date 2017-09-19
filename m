From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 19 Sep 2017 10:48:49 +0200
Subject: [LTP] LTP release and code freeze
Message-ID: <20170919084849.GA14328@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
We are getting closer to a release, here is the status as I see it.

Blockers:

* thp01 failing on newer kernels
  - I'm waiting for v4 from Ritchie

* utimensat01 failing on stable kernels
  - That thread on ML is kind of stuck,
    I guess that we will have to accept
    both errors for some range of kernels


Nice to have:

* The clone09 patch to disable it on old kernels looks sane to me
   - I will merge that one

* CVE synchronization library
   - depends if Ritchie can fix it fast enough

* The .needs_rofs patchset looks good to me as well I guess that
  it's safe enough to be included in the release as well


Is there anything else I've missing?

-- 
Cyril Hrubis
chrubis@suse.cz
