From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 1 Mar 2019 12:16:33 +0100
Subject: [LTP] [PATCH] travis: Use official opensuse images
In-Reply-To: <20190301104528.GA1361@rei>
References: <20190301103304.20233-1-pvorel@suse.cz> <20190301104528.GA1361@rei>
Message-ID: <20190301111632.GA25508@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Cyril,

> > We're using deprecated opensuse images [1] [2] which has been now
> > removed, which cause travis failures. Replace them with the official
> > ones.

> > [1] https://hub.docker.com/_/opensuse/
> > [2] https://github.com/docker-library/official-images/issues/5371

> That looks obvious enough to go in without review, acked anyways.
Thanks, pushed (with installed gzip =E2=80=93 not installed by default).

Kind regards,
Petr
