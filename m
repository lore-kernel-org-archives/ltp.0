From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Aug 2018 16:48:22 +0200
Subject: [LTP] [PATCH v2] syscalls/execveat01: new test to verify
 execveat unlinked fd
In-Reply-To: <20180808144155.GG19147@rei>
References: <1533111474.1176.4.camel@mtkswgap22>
 <CAEemH2dsg0Z18taXrBeQvCkJF1WHh9fHbP=GvMzRV62h4kNCzg@mail.gmail.com>
 <CALLuPvp4Ay5F_giNiUuDR9By+eLNPUNT-perUOE=gbCSmbsc2A@mail.gmail.com>
 <CAEemH2f8di2qLvKPmutiO64w+YOxVbHxZgggvqtM-TPS5TU8eg@mail.gmail.com>
 <20180808144155.GG19147@rei>
Message-ID: <20180808144822.GH19147@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I will write the code to check it and amend the test before applying to
> the tree.

Actually it seems to be easier than this, if we do
execveat(-1, "", NULL, NULL, AT_EMPTY_PATH); we get EBADFD if execveat is
supported and EINVAL if not.

-- 
Cyril Hrubis
chrubis@suse.cz
