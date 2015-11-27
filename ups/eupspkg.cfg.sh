# EupsPkg config file. Sourced by 'eupspkg'

config()
{
    # TokuDB requires third-party software jemalloci (see http://www.canonware.com/jemalloc/)
    cmake . -DCMAKE_INSTALL_PREFIX=${PREFIX} -DPLUGIN_TOKUDB=NO
}
