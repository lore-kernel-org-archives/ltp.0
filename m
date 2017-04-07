From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Apr 2017 11:19:45 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170407105832.6f9d811a@linux-v3j5>
References: <20170406124641.30179-1-chrubis@suse.cz>
 <20170407105832.6f9d811a@linux-v3j5>
Message-ID: <20170407091945.GA536@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +ifeq ($(filter -m32,$(CFLAGS)),)
> > +$(MAKE_TARGETS): LDFLAGS += -L$(top_builddir)/lib$(subst -m,,$(filter -m32,$(CFLAGS)))
> > +else
> > +LDFLAGS			 += -L$(top_builddir)/lib
> > +endif
> 
> I think this breaks the build if you do 'make CFLAGS+=-m32' or './configure
> CFLAGS=-m32' to build everything in compatability mode. Am I doing it wrong or
> is this an issue?

If -m32 is in CFLAGS the $(filter -m32,$(CFLAGS)) is nonempty and we
will add -L$(top_builddir)/lib regardless. We will build the lib32 as
well but never use it.

And you have to pass LDLAGS=-m32 to the configure script as well, since
the implicit rule to build an executable from list of object files is:

$(CC) $(LDFLAGS) n.o $(LOADLIBES) $(LDLIBS)

Hence if you pass -m32 only to CFLAGS the compiler will fail to link the
ltp-pan binary.

Passing -m32 in CFLAGS only works for testcases though, since they are
compiled and linked in one try and hence use both LDFLAGS and CFLAGS.

> > +#
> > +# You should have received a copy of the GNU General Public License along
> > +# with this program; if not, write to the Free Software Foundation, Inc.,
> > +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> > +#
> 
> Minor nit: should be e-mail.

Ok. I guess that we should use recent enough headers...

-- 
Cyril Hrubis
chrubis@suse.cz
