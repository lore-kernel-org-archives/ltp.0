From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Wed, 2 May 2018 17:46:21 +0200
Subject: [LTP] runltp - error when using another tmp folder
In-Reply-To: <20180502162214.5d962173@dell-desktop.home>
References: <20180502162214.5d962173@dell-desktop.home>
Message-ID: <20180502174621.6087aaea@windsurf>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hello,

On Wed, 2 May 2018 16:22:14 +0200, Myl=C3=A8ne Josserand wrote:

> After looking at the code, Thomas (in CC) and myself found that the
> "temp" folder that we used (with "-d" option on "runltp") does not have
> a permission of 777.
> According to the code of runltp, it seems that it creates a folder with
> this permission but because it is retrieving the option using
> "readlink", if the folder is not available, it leads to an error
> because TMPBASE variable is empty:

Hum, I think the situation is a bit more complicated than that. The
runltp code goes like this:

            export TMPBASE=3D$(readlink -f ${OPTARG}) ;;
[...]

    # Added -m 777 for tests that call tst_tmpdir() and try to
    #  write to it as user nobody
    mkdir -m 777 -p $TMPBASE || \
    {
        echo "FATAL: Unable to make temporary directory $TMPBASE"
        exit 1
    }
    # use mktemp to create "safe" temporary directories
    export TMPTEMPLATE=3D"${TMPBASE}/ltp-XXXXXXXXXX"
    TMP=3D`mktemp -d $TMPTEMPLATE` || \
    {
        echo "FATAL: Unable to make temporary directory: $TMP"
        exit 1
    }
    export TMP
    # To be invoked by tst_tmpdir()
    # write to it as user nobody
    export TMPDIR=3D$TMP

    chmod 777 $TMP || \
    {
      echo "unable to chmod 777 $TMP ... aborting"
      exit 1
    }

So you've got two possible situations:

 (1) TMPBASE is an already existing directory. In this case, the "-m
     777" argument in mkdir -m 777 -p $TMPBASE is useless because it is
     only used by mkdir when the directory to be created doesn't exist
     yet.

 (2) TMPBASE is not an existing directory. In this case, readlink will
     return an empty string, and mkdir will fail because TMPBASE is
     empty.

> Currently, we fixed the issue by using a /tmp folder that already has
> 777 permission (default's one) but maybe, other users may want to use
> another folder and may have the same error we got.

Now that I look at the code again, in the end, I don't understand why
the user nobody was not able to create its temporary files. Indeed,
TMPDIR which gets exported to tests, and is used by tst_tmpdir() is
defined as:

 TMPDIR =3D $TMPBASE/ltp-XXXXXXXXXX/

and this directory is chmod 777. So even if TMPBASE is only
root-writable, TMPDIR should be world-writable. So there's something we
misunderstood here.

That being said, that doesn't remove the bug on how TMPBASE is handled,
which is described above.

Best regards,

Thomas
--=20
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
