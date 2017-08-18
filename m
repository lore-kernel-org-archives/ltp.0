From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Aug 2017 15:38:03 +0200
Subject: [LTP] [PATCH v2] syscalls/keyctl04: new test for thread keyring
 memory leak
In-Reply-To: <20170801004626.108851-1-ebiggers3@gmail.com>
References: <20170801004626.108851-1-ebiggers3@gmail.com>
Message-ID: <20170818133802.GE22319@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've added a lapi/keyctl.h header to LTP with a fallback definitions,
which is more or less standard way how we deal with possibly missing
headers since that way we get to use the one available on system if
present and changed the tests to make use of it.

And pushed both patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
