From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Oct 2015 14:16:49 +0200
Subject: [LTP] LTP Question
In-Reply-To: <CAKxdZb-3b+K+p_dXy++rfMTFTSjvP+V9RTMVBt1Ac923d=jvwg@mail.gmail.com>
References: <CAKxdZb-3b+K+p_dXy++rfMTFTSjvP+V9RTMVBt1Ac923d=jvwg@mail.gmail.com>
Message-ID: <20151001121648.GG8256@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have already mailed developers about LTP and didn't recieve any
> response.

Whom did you mailed? This mailing list is the only official way how to
contact LTP developers.

> I told them in previous email that I want to run LTP-2015-04-20 for
> testing the fedora linux based on eal4 certification (that is included
> LTP-2007-02-28). But there are some testcases in eal4 certification
> that are not in LTP-2015-04-20 like login_test.c testcase and so on.
> I would be grateful if you could help me about this matter.  Yours
> sincerely,

The testcases/audit/ directory was never part of LTP. Not even for the
2007 release.

Rather than that the archive with modified LTP was dumped to the sf.net
LTP download area.

-- 
Cyril Hrubis
chrubis@suse.cz
