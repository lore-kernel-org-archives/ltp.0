From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 7 Apr 2017 10:58:32 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170406124641.30179-1-chrubis@suse.cz>
References: <20170406124641.30179-1-chrubis@suse.cz>
Message-ID: <20170407105832.6f9d811a@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu,  6 Apr 2017 14:46:41 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> +ifeq ($(filter -m32,$(CFLAGS)),)
> +$(MAKE_TARGETS): LDFLAGS += -L$(top_builddir)/lib$(subst -m,,$(filter -m32,$(CFLAGS)))
> +else
> +LDFLAGS			 += -L$(top_builddir)/lib
> +endif

I think this breaks the build if you do 'make CFLAGS+=-m32' or './configure
CFLAGS=-m32' to build everything in compatability mode. Am I doing it wrong or
is this an issue?

> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +#

Minor nit: should be e-mail.

> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program; if not, write the Free Software Foundation,
> +dnl Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +dnl

Again, e-mail.

Tested it on 64-bit Tumbleweed and 32-bit SLES11. It works fine except for
issue mentioned above. I can't comment on whether the approach is correct.

Thank you,
Richard.
