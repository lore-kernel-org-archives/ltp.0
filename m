From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Nov 2017 16:41:19 +0800
Subject: [LTP] [RFC PATCH 1/4] travis: Add build script
In-Reply-To: <20171129082743.d5i5stufxmn25twr@dell5510>
References: <20171128232130.4843-1-pvorel@suse.cz>
 <20171128232130.4843-2-pvorel@suse.cz>
 <CAEemH2evorTPAHpnYjydKcvwYha27zYSPZGKLZe+97Mni7N7vA@mail.gmail.com>
 <20171129082743.d5i5stufxmn25twr@dell5510>
Message-ID: <CAEemH2fG=O7vVj=xyY58gwQLkq5JUw4fa4yaUEMAyoJfWE0V_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 29, 2017 at 4:27 PM, Petr Vorel <pvorel@suse.cz> wrote:
> Hi Li,
>
>> How about adding a new function for ltp build out of tree?
>
>> build_out_of_tree()
>> {
>>        echo "===== build ltp out of tree ====="
>> ...
>> }
> I'm planning it, but first we need to actually fix out of tree build.
> Well, It's not broken, but it does not install all files (make install is
> broken), so technically I could add it.

Hmm, what kind of files will be missed?

I just tried your build.sh with this new function, but seems make
install successfully.

build_out_of_tree()
{
    echo "===== build ltp out of tree ====="
    TOP=$PWD
    TOP_SRCDIR=$TOP/../ltp
    SYSROOT=$TOP/../ltp-install
    TOP_BUILDDIR=$TOP/../ltp-build
    test -d "$TOP_BUILDDIR" || mkdir -p "$TOP_BUILDDIR"

    pushd $TOP_SRCDIR; make autotools; popd

    pushd "$TOP_BUILDDIR" && "$TOP_SRCDIR/configure"
    OUT_OF_BUILD_TREE_DIR=$TOP_BUILDDIR
    make \
        -C "$OUT_OF_BUILD_TREE_DIR" \
        -f "$TOP_SRCDIR/Makefile" \
        "top_srcdir=$TOP_SRCDIR" \
        "top_builddir=$OUT_OF_BUILD_TREE_DIR"

    make \
        -C "$OUT_OF_BUILD_TREE_DIR" \
        -f "$TOP_SRCDIR/Makefile" \
        "top_srcdir=$TOP_SRCDIR" \
        "top_builddir=$OUT_OF_BUILD_TREE_DIR" \
        "DESTDIR=$SYSROOT" \
        SKIP_IDCHECK=1 install
    popd
}


>
>> > +case "$1" in
>> > +       -h|--help|help) usage; exit 0;;
>
>
>>             -o|--out) build="build_out_of_tree";;
>
>> > +       32) build="build_32";;
>> > +       *) build="build_native";;
> I decided not to use getopts, as we'd have to use getopt from util-linux (getopts shell
> builtin does not handle long opts.
>
>
> Kind regards,
> Petr
>



-- 
Li Wang
liwang@redhat.com
