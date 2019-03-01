From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 1 Mar 2019 11:41:58 +0100
Subject: [LTP] [PATCH v2 2/2] rt_sigpending: add rt_sigpending02 test
	case
In-Reply-To: <e67b74d5-554f-1858-7ec7-5693b5158ce7@google.com>
References: <20190207155153.41816-1-maennich@google.com>
 <20190212161236.74385-1-maennich@google.com>
 <20190212161236.74385-3-maennich@google.com>
 <2ad02580-8de8-b4a9-38a6-c14f507d8741@google.com>
 <5e4da8a6-f495-ebe6-f457-1a564f4ebc4d@google.com>
 <e67b74d5-554f-1858-7ec7-5693b5158ce7@google.com>
Message-ID: <20190301104158.GA18192@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Matthias, Steve,

> On 02/19/2019 06:28 AM, Matthias M=C3=A4nnich wrote:
> > I added rt_sigpending02 to runtest/syscalls here. sigpending02 has
> > already been there before.

> Sigh, not sure how I missed that. Sorry for the noise!

> Reviewed-by: Steve Muckle <smuckle@google.com>

Both commits merged, thanks!

BTW maybe you have noticed ticket about using libc wrapper vs. direct
syscall [1].
Build failure of your commit is caused by our docker image [2]

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/506
[2] http://lists.linux.it/pipermail/ltp/2019-March/011050.html
